(() => {
  // src/components/AppRoot/index.js
  var AppRoot = class extends HTMLElement {
    elements = {};
    state = {
      user: "",
      time: "00:00",
      mode: "default"
    };
    constructor() {
      super();
      window.updateState = this.updateState.bind(this);
      const template = document.getElementById("app-root-template");
      const shadowRoot = this.attachShadow({ mode: "open" });
      shadowRoot.appendChild(template.content.cloneNode(true));
      this.elements.time = this.querySelector("[slot=time]");
      this.elements.user = this.querySelector("[slot=user]");
      this.elements.mode = this.querySelector("[slot=mode]");
    }
    updateState(state) {
      Object.entries(state).forEach(([key, value]) => {
        this.state[key] = value;
      });
      this.render();
    }
    render() {
      this.elements.time.textContent = this.state.time;
      this.elements.user.textContent = this.state.user;
      this.elements.mode.textContent = this.state.mode;
      this.setAttribute("data-mode", this.state.mode);
    }
  };
  customElements.define("app-root", AppRoot);
  var AppRoot_default = AppRoot;

  // src/index.js
  window.onload = function() {
    window.webkit.messageHandlers.statusbar.postMessage("onload");
  };
})();
