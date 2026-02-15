class CraftTracker {
    constructor() {
        this.projects = this.loadProjects();
        this.currentProject = null;
        this.initializeEventListeners();
        this.renderProjects();
        this.registerServiceWorker();
    }

    loadProjects() {
        const stored = localStorage.getItem('craftProjects');
        return stored ? JSON.parse(stored) : [];
    }

    saveProjects() {
        localStorage.setItem('craftProjects', JSON.stringify(this.projects));
    }

    initializeEventListeners() {
        document.getElementById('addProjectBtn').addEventListener('click', () => {
            this.openModal('addProjectModal');
        });
        document.getElementById('saveProjectBtn').addEventListener('click', () => {
            this.saveProject();
        });
        document.getElementById('incrementBtn').addEventListener('click', () => {
            this.updateStitchCount(1);
        });
        document.getElementById('decrementBtn').addEventListener('click', () => {
            this.updateStitchCount(-1);
        });
        document.getElementById('resetBtn').addEventListener('click', () => {
            this.resetStitchCount();
        });
        document.addEventListener('keydown', (e) => {
            if (this.currentProject) {
                if (e.key === 'ArrowUp' || e.key === '+') {
                    e.preventDefault();
                    this.updateStitchCount(1);
                } else if (e.key === 'ArrowDown' || e.key === '-') {
                    e.preventDefault();
                    this.updateStitchCount(-1);
                }
            }
        });
    }

    openModal(modalId) {
        document.getElementById(modalId).classList.remove('hidden');
        if (modalId === 'addProjectModal') {
            document.getElementById('projectName').focus();
        }
    }

    closeModal(modalId) {
        document.getElementById(modalId).classList.add('hidden');
        if (modalId === 'addProjectModal') {
            document.getElementById('projectName').value = '';
            document.getElementById('projectDescription').value = '';
            document.getElementById('projectType').value = 'knitting';
        }
    }

    saveProject() {
        const name = document.getElementById('projectName').value.trim();
        const type = document.getElementById('projectType').value;
        const description = document.getElementById('projectDescription').value.trim();
        if (!name) {
            alert('Please enter a project name');
            return;
        }
        const project = {
            id: Date.now().toString(),
            name,
            type,
            description,
            stitchCount: 0,
            createdAt: new Date().toISOString()
        };
        this.projects.push(project);
        this.saveProjects();
        this.renderProjects();
        this.closeModal('addProjectModal');
    }

    renderProjects() {
        const projectList = document.getElementById('projectList');
        if (this.projects.length === 0) {
            projectList.innerHTML = `
                <div class="empty-state">
                    <div class="material-icons">add_circle_outline</div>
                    <p>No projects yet. Create your first project!</p>
                </div>
            `;
            return;
        }
        projectList.innerHTML = this.projects.map(project => `
            <div class="project-item ${this.currentProject?.id === project.id ? 'active' : ''}"
                 onclick="app.selectProject('${project.id}')">
                <div class="project-info">
                    <h3>${project.name}</h3>
                    <p>${project.type} • ${project.stitchCount} stitches</p>
                    ${project.description ? `<p>${project.description}</p>` : ''}
                </div>
                <div class="project-actions">
                    <button class="icon-btn" onclick="event.stopPropagation(); app.deleteProject('${project.id}')" title="Delete">
                        <span class="material-icons">delete</span>
                    </button>
                </div>
            </div>
        `).join('');
    }

    selectProject(projectId) {
        this.currentProject = this.projects.find(p => p.id === projectId);
        if (this.currentProject) {
            document.getElementById('stitchTracker').classList.remove('hidden');
            document.getElementById('stitchCount').textContent = this.currentProject.stitchCount;
            this.renderProjects();
        }
    }

    deleteProject(projectId) {
        if (confirm('Are you sure you want to delete this project?')) {
            this.projects = this.projects.filter(p => p.id !== projectId);
            if (this.currentProject?.id === projectId) {
                this.currentProject = null;
                document.getElementById('stitchTracker').classList.add('hidden');
            }
            this.saveProjects();
            this.renderProjects();
        }
    }

    updateStitchCount(delta) {
        if (!this.currentProject) return;
        this.currentProject.stitchCount = Math.max(0, this.currentProject.stitchCount + delta);
        document.getElementById('stitchCount').textContent = this.currentProject.stitchCount;
        const index = this.projects.findIndex(p => p.id === this.currentProject.id);
        if (index !== -1) {
            this.projects[index] = this.currentProject;
        }
        this.saveProjects();
        this.renderProjects();
        const display = document.getElementById('stitchCount');
        display.style.transform = 'scale(1.1)';
        setTimeout(() => {
            display.style.transform = 'scale(1)';
        }, 150);
    }

    resetStitchCount() {
        if (!this.currentProject) return;
        if (confirm('Are you sure you want to reset the stitch counter to 0?')) {
            this.currentProject.stitchCount = 0;
            document.getElementById('stitchCount').textContent = '0';
            const index = this.projects.findIndex(p => p.id === this.currentProject.id);
            if (index !== -1) {
                this.projects[index] = this.currentProject;
            }
            this.saveProjects();
            this.renderProjects();
        }
    }

    async registerServiceWorker() {
        if ('serviceWorker' in navigator) {
            try {
                await navigator.serviceWorker.register('sw.js');
                console.log('Service Worker registered successfully');
            } catch (error) {
                console.log('Service Worker registration failed:', error);
            }
        }
    }
}

function closeModal(modalId) {
    document.getElementById(modalId).classList.add('hidden');
    if (modalId === 'addProjectModal') {
        document.getElementById('projectName').value = '';
        document.getElementById('projectDescription').value = '';
        document.getElementById('projectType').value = 'knitting';
    }
}

const app = new CraftTracker();
let deferredPrompt;
window.addEventListener('beforeinstallprompt', (e) => {
    deferredPrompt = e;
});

document.addEventListener('DOMContentLoaded', function() {
    // Modal close logic for Add Project Modal
    const addProjectModal = document.getElementById('addProjectModal');
    const closeBtn = addProjectModal.querySelector('.close-btn');
    const cancelBtn = addProjectModal.querySelector('.btn.btn-secondary');

    function closeModal() {
        addProjectModal.classList.add('hidden');
    }

    closeBtn.addEventListener('click', closeModal);
    cancelBtn.addEventListener('click', closeModal);
});
