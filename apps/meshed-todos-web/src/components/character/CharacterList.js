import React, { useState, useCallback } from "react";

import SearchForm from "./SearchForm";
import CharacterCard from "./CharacterCard";
import PageLimit from "./PageLimit";
import { useRenderer } from "../../common";
import { defaultSearchState } from "../../api/marvelApi";
import { useFetchCharacters } from "../../api/useMarvel";

function CharacterList() {
  useRenderer('CharacterList');
  const [searchState, setSearchState] = useState({
    limit: defaultSearchState.limit,
    characterName: defaultSearchState.characterName
  });

  // const [result, setResult] = useState({
  //   error: null,
  //   characters: [],
  //   loading: false
  // });

  // const handleSearch = async character => {
  //   setResult(prev => ({ ...prev, loading: true }));
  //   const apiResponse = await getCharacters(character.trim());
  //   const _characters = (apiResponse.data.results || []).map(result => {
  //     return {
  //       ...result,
  //       thumbnail: {
  //         ...result.thumbnail,
  //         path: result.thumbnail.path.replace(/^http:\/\//i, "https://")
  //       }
  //     };
  //   });
  //   setResult(prev => ({ ...prev, loading: false, characters: _characters }));
  // };
  // const isLoading = result.loading ? <h3>Loading ...</h3> : null;

  // const renderCharacters = (
  //   <div className="card-columns">
  //     {result.characters.map(character => (
  //       <CharacterCard key={character.id} {...character} />
  //     ))}
  //   </div>
  // );

  const { data, loading } = useFetchCharacters(searchState);

  const handleSearch = characterName => {
    setSearchState(prev => ({
      ...prev,
      characterName: characterName,
      limit: defaultSearchState.limit
    }));
  };
  const isLoading = loading ? <h3>Loading ...</h3> : null;

  const renderCharacters = data && (
    <div className="card-columns">
      {data.map(character => (
        <CharacterCard key={character.id} {...character} />
      ))}
    </div>
  );

  const handleLimitClick = useCallback(
    limit => {
      setSearchState(prev => ({ ...prev, limit: limit }));
    },
    [setSearchState]
  );
  return (
    <>
      <h3>Search Mavel Characters</h3>
      <div className="row">
        <div className="col">
          <SearchForm onSearch={handleSearch} />
        </div>
        <div className="col">
          {[10, 20, 30].map(limit => (
            <PageLimit
              key={limit}
              limit={limit}
              selected={searchState.limit}
              onLimitClick={handleLimitClick}
            />
          ))}
        </div>
      </div>

      {isLoading}
      {renderCharacters}
    </>
  );
}

export default CharacterList;
