class AppRoot extends HTMLElement {
  static updateState(state) {
    console.log(state);
  }

  constructor() {
    super();
    let template = document.getElementById("app-root-template");
    let templateContent = template.content;

    const shadowRoot = this.attachShadow({ mode: "open" });
    shadowRoot.appendChild(templateContent.cloneNode(true));
  }
}

export default AppRoot;

window.updateState = AppRoot.updateState;

customElements.define("app-root", AppRoot);
