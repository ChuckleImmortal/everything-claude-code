from functools import lru_cache

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8", extra="ignore")

    database_url: str = "postgresql+asyncpg://cos:cos@localhost:5432/cos"
    neo4j_uri: str = "bolt://localhost:7687"
    neo4j_user: str = "neo4j"
    neo4j_password: str = "cos-neo4j-dev"
    cors_origins: str = "http://localhost:3000,http://127.0.0.1:3000"

    openai_model_reasoning: str = "gpt-4o"
    openai_model_standard: str = "gpt-4o-mini"
    openai_model_fast: str = "gpt-4o-mini"


@lru_cache
def get_settings() -> Settings:
    return Settings()
