provider "oci" {}

resource "oci_core_instance" "generated_oci_core_instance" {
	agent_config {
		is_management_disabled = "false"
		is_monitoring_disabled = "false"
		plugins_config {
			desired_state = "DISABLED"
			name = "WebLogic Management Service"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Vulnerability Scanning"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Oracle Java Management Service"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "OS Management Service Agent"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "OS Management Hub Agent"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Management Agent"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Custom Logs Monitoring"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Compute RDMA GPU Monitoring"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Compute Instance Run Command"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Compute Instance Monitoring"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Compute HPC RDMA Auto-Configuration"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Compute HPC RDMA Authentication"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Cloud Guard Workload Protection"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Block Volume Management"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Bastion"
		}
	}
	availability_config {
		is_live_migration_preferred = "true"
		recovery_action = "RESTORE_INSTANCE"
	}
	availability_domain = "trUa:US-ASHBURN-AD-3"
	compartment_id = "ocid1.tenancy.oc1..aaaaaaaaltnvzkomyd7iybe726eiyse75rigvr7u7mtihfuzgubc42xow2la"
	create_vnic_details {
		assign_ipv6ip = "false"
		assign_private_dns_record = "true"
		assign_public_ip = "true"
		subnet_id = "ocid1.subnet.oc1.iad.aaaaaaaa6ksli6lj5dsb5y4gdjj4fb52bitpuf5s6ljw7j5n4j24ciq3yneq"
	}
	display_name = "instance-20250411-0828"
	instance_options {
		are_legacy_imds_endpoints_disabled = "false"
	}
	metadata = {
		"ssh_authorized_keys" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCc9KdZcUmGIEnUxU1Ag13lepxmYZzOy6njII8X0/A3FTBnJ2hxXEMx7Tlj65SmemMjOul1VNbIkpN7ec2+I6+B0E1a7m2nmk3zWBZLXep/BVKSC7OGiCakqITgVpGL0PwvwyXhGJobb6flyRAOE9cyV9siuYNhmMthNPFG2hkMgMo3R9QAEcVcesc2PDp4t7PY16WRlpLqI/497UEniJlsWKkt1IQSIPP7UbRV1R1JMO57aONZ/fGGrDbkk+mGxEPZEKFa1JxSF37MOSiorWP8cQr+YixEL3GUJby9s/l7amw0y0Nfmpr43g5qeAxj82Z4KH+wTtIG9AmZ7OJ292tAFXaTqrLkwQxKlkcKP4/F1JiEKJJEI21vzd4qLUQ7mLQjoraRFe96vDs39Vt/rVtxgNJqiadc1VjYPVKMbcFJrvYVIDedEy0OjIRuDwIpoMVmQACOSTJVqD+uq+V31pdvmDMSq54R54MSBZ5BICq20FL/YyKp02aEBgkGz1FZJ1Z1XGbTkNETbplBQ64wgiGqjJiTy4/hI1dBgnvW2i09DvKQ0iYWP5dZK8c4i7PW+9znvy01Aiat2NOYp/PMFjd18I1MkkdIZ33NQsoIF1RCuVyDuJ4teLmUnrTDErlXBoKLjb09nwSqxLyf8gYG5cVpPrqNlt6ww5L/RTEDNcDS3w=="
	}
	shape = "VM.Standard.A1.Flex"
	shape_config {
		memory_in_gbs = "12"
		ocpus = "4"
	}
	source_details {
		source_id = "ocid1.image.oc1.iad.aaaaaaaa3zzp4jue2jp5wm2hesslxoq27qqrzxfwdxylcabkv3ginqacgqra"
		source_type = "image"
	}
}
