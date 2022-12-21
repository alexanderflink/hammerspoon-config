export { default } from "./components/AppRoot";

window.onload = function () {
  window.webkit.messageHandlers.statusbar.postMessage("onload");
};
