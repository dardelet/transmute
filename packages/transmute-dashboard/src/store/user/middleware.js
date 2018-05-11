import axios from 'axios';

const ENVS = {
  LOCAL: 'http://localhost:5000',
  TEST: '???',
  PROD: 'https://transmute-api.herokuapp.com'
};

export const register = async ({ firstName, lastName, email }) => {
  return axios
    .create({
      baseURL: ENVS.PROD,
      headers: {
        'Content-Type': 'application/json',
        Accept: 'application/json'
      }
    })
    .post('/api/v0/users', {
      profile: {
        firstName,
        lastName,
        email: email,
        login: email
      }
    });
};

export const requestEthereumChallenge = async (auth) => {
  let access_token = await auth.getAccessToken();
  let user = await auth.getUser();
  let address = '0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf';
  return axios
    .create({
      baseURL: ENVS.LOCAL,
      headers: {
        'Content-Type': 'application/json',
        Accept: 'application/json',
        'Authorization': `Bearer ${access_token}`
      }
    })
    .get(`/api/v0/users/${user.sub}/challenge`, {
      params: {
        address
      }
    });
};
