import ReactDOM from 'react-dom'
import React from 'react'
import App from "./components/App";
import { AuthClient } from "@dfinity/auth-client";

const init = async () => { 

  
  const authClient = await AuthClient.create();
  if (await authClient.isAuthenticated()) {
    handleAuthentication(authClient);
  } else {
    await authClient.login({
      identityProvider: "https://identity.ic0.app/#authorize",
      onSuccess: () => {
        handleAuthentication(authClient);
      }
    })
  };

  async function handleAuthentication(authClient){
    const identity = await authClient.getIdentity();
    const userPrincipal = identity._principal;

    ReactDOM.render(<App loggedInPrincipal={userPrincipal}/>, document.getElementById("root"));
  };
};

init();


