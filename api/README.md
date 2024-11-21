# README

# Species Location API

## Overview
This Rails application provides an API for querying species information based on geographical locations and scientific name identifiers. The application utilizes caching to improve performance and reduce database load.

## Design Approach

### Architecture
- The application follows a standard Rails MVC (Model-View-Controller) architecture.
- It is designed as an API-only application, focusing on JSON responses.
- The API is versioned (currently at V1) to allow for future updates without breaking existing clients.

### Database Schema
The application uses PostgreSQL and consists of three main tables:
1. **locations**: Stores distinct geographical data include longitude, latitude and other geo related data
2. **species**: Contains distinct specie information include their scientific name, id, genus, etc.
3. **specie_locations**: A join table linking species to locations.

Key features of the schema:
- Precise geographical coordinates (latitude and longitude) with indexing for efficient queries.
- Many-to-many relationship between species and locations.

### Models
1. **Location**: Represents a geographical location 
2. **Specie**: Represents a specie 
3. **SpecieLocation**: Join model for the many-to-many relationship.

The models use Rails associations to establish relationships:
- A location has many species through `specie_locations`.
- A species has many locations through `specie_locations`.

### Data Import
The app includes a Rake task for importing data from a CSV file containing species and location details. This was implemnted with 
idempotency in mind to prevent duplicate records when the task is re-run.

### Controllers
The `V1::SpeciesController` handles two main endpoints:
1. **by_location**: Retrieves species for a given latitude and longitude.
2. **by_scientific_name_id**: Retrieves species and their locations for a given scientific name ID.

### Serialization
- Uses Blueprinter for JSON serialization (`SpecieSerializer`).
- Custom serialization logic to include location data with species information.

### Caching
- Implemented caching using Rails' built-in caching mechanisms to improve performance.
- Results from database queries are cached for 1 hour using unique keys based on query parameters.
- Caching reduces database load and improves response times for repeated queries.

### Error Handling
- Implements rescue blocks to handle common errors (e.g., `RecordNotFound`).
- Logs unexpected errors and returns appropriate HTTP status codes.

### API Design
- RESTful API design principles are followed.
- Versioning is implemented through URL namespacing (e.g., `/v1/`).
- Query parameters are used for filtering (latitude, longitude, scientific_name_id).

### Performance Considerations
- Database indexing on frequently queried fields (latitude, longitude, scientific_name_id).
- Caching strategies to minimize redundant database access.

### Best Practices
- Use of strong parameters (implied by Rails conventions).
- Separation of concerns between models, controllers, and serializers.
- Consistent error handling and reporting.

## API Endpoints

1. **GET** `/v1/species/by_location`
    - **Parameters**: `latitude`, `longitude`
    - **Returns**: List of species at the specified location

2. **GET** `/v1/species/by_scientific_name_id`
    - **Parameters**: `scientific_name_id`
    - **Returns**: List of species with their locations for the given scientific name ID

## Future Improvements
- Implement pagination for large result sets.
- Add authentication and authorization for API access.
- Enhance error messages with more detailed information.

## Running the API
Information about running the api is included in parent [README](../README.md)