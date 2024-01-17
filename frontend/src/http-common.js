import axios from "axios";


const BACKEND_HOST = process.env.REACT_APP_BACKEND_HOST || "localhost";
const BACKEND_PORT = process.env.REACT_APP_BACKEND_PORT || "8080";

export default axios.create({
  baseURL: "http://"+BACKEND_HOST+":"+BACKEND_PORT+"/api",
  headers: {
    "Content-type": "application/json"
  }
});
