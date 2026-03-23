"""
Ingest worker — transcription, chunking, entity/claim extraction, graph insertion requests.

Run as a scheduled job or queue consumer (wired in Phase 1).
"""

def main() -> None:
    print("cos-ingest-worker: stub — connect queue and OpenAI/Neo4j in Phase 1")


if __name__ == "__main__":
    main()
