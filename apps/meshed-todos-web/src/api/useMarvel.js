import { useState, useEffect } from "react";
import { baseUrl, apiKey } from "./marvelApi";
import { handleResponse, handleError } from "./apiUtils";

const FetchCharacters = ({ characterName = "", limit = 10 }) => {
  const url = `${baseUrl}?apikey=${apiKey}&orderBy=name&offset=0&limit=${limit}`;
  let controller = new AbortController();
  const [response, setResponse] = useState({ data: null, loading: true });
  useEffect(() => {
    setResponse(prev => ({ data: prev.data, loading: true }));

    const getData = async () => {
      return await fetch(
        characterName ? url + `&nameStartsWith=${characterName}` : url,
        {
          signal: controller.signal
        }
      )
        .then(handleResponse)
        .catch(handleError);
    };
    (async () => {
      const response = await getData();
      const results = response.data.results.map(result => ({
        ...result,
        thumbnail: {
          ...result.thumbnail,
          path: result.thumbnail.path.replace(/^http:\/\//i, "https://")
        }
      }));
      setResponse(prev => ({ data: results, loading: false }));
    })();

    return () => {
      controller.abort();
    };
  }, [characterName, limit]);

  return response;
};

export const useFetchCharacters = FetchCharacters;
