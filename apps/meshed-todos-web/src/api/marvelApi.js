import { handleResponse, handleError } from "./apiUtils";

export const baseUrl = "https://gateway.marvel.com/v1/public/characters";
export const apiKey = "aa3485b25e201d8b697d3ebe3db00d93";
export const defaultSearchState = {
  characterName: "",
  limit: 10
};

export const getCharacters = name => {
  const uri = `${baseUrl}?apikey=${apiKey}&orderBy=name&limit=10&offset=0`;
  return fetch(name ? uri + `&nameStartsWith=${name}` : uri)
    .then(handleResponse)
    .catch(handleError);
};
