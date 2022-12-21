class AppRoot extends HTMLElement {
  elements = {};
  state = {
    user: "",
    time: "00:00",
  };

  constructor() {
    super();

    window.updateState = this.updateState.bind(this);

    const template = document.getElementById("app-root-template");

    const shadowRoot = this.attachShadow({ mode: "open" });
    shadowRoot.appendChild(template.content.cloneNode(true));
    this.elements.time = this.querySelector("[slot=time]");
    this.elements.user = this.querySelector("[slot=user]");
  }

  updateState(state) {
    console.log("updateState", state);

    Object.entries(state).forEach(([key, value]) => {
      this.state[key] = value;
    });

    this.render();
  }

  render() {
    this.elements.time.textContent = this.state.time;
    this.elements.user.textContent = this.state.user;
  }
}

customElements.define("app-root", AppRoot);

export default AppRoot;
