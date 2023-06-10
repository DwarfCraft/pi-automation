import express, { Application } from "express";
import fs from "fs";
import dns from "dns";
import WebSocket from "ws";
import materialUi from "material-ui";

const app: Application = express();

app.get("/", (req, res) => {
  const jsonData = fs.readFileSync("ip_ports.json", "utf8");
  const ipPortList: { ip: string; port: number }[] = JSON.parse(jsonData);

  const results: { ip: string; port: number; status: string }[] = [];

  for (const ipPort of ipPortList) {
    const ip = ipPort.ip;
    const port = ipPort.port;

    try {
      dns.resolve(ip, function(err, addresses) {
        if (err) {
          results.push({
            ip,
            port,
            status: "Error resolving IP address",
          });
        } else {
          const address = addresses[0];
          const socket = new WebSocket(`ws://${address}:${port}`);
          socket.onopen = function() {
            results.push({
              ip,
              port,
              status: "Connected",
            });
          };
          socket.onclose = function() {
            results.push({
              ip,
              port,
              status: "Disconnected",
            });
          };
        }
      });
    } catch (err) {
      results.push({
        ip,
        port,
        status: "Error connecting to host",
      });
    }
  }

  res.render("index", {
    results,
  });
});

app.listen(3000, () => {
  console.log("App listening on port 3000");
});

app.use(materialUi());

const index = () => {
  const [results, setResults] = useState<{ ip: string; port: number; status: string }[]>([]);

  useEffect(() => {
    fetch("/", {
      method: "GET",
    })
      .then(response => response.json())
      .then(json => setResults(json));
  }, []);

  return (
    <div>
      <h1>Network Connectivity Test Results</h1>
      <table>
        <thead>
          <tr>
            <th>IP Address</th>
            <th>Port</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          {results.map((result, index) => (
            <tr key={index}>
              <td>{result.ip}</td>
              <td>{result.port}</td>
              <td>{result.status}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default index;
