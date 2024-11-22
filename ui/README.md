
# README

# Species Locator with Mapbox

## Overview
This Nuxt application is designed to display geospatial datasets using Mapbox and integrate with API endpoints for querying species information based on geographical locations and scientific name identifiers. It provides an interactive map with clustering, pagination, and modal-based UI for detailed species and location data.


## Features

### Interactive Map with Clustering:
- High-proximity clusters are highlighted in red, while low-proximity clusters are shown in gray.
- Clicking on individual points provides details about the species in a modal.

### Pagination and Tabs:
- A paginated view to navigate through species or locations.
- Tabs to toggle between species and locations.
- Reusable Components with VueTailwind:Includes modal, button, and pagination components styled and integrated with VueTailwind.

### API Integration:
- Endpoints for fetching species by location and locations by species have been integrated seamlessly.

### State Management
- Used Vuex for scalable and centralized state management.
- The map module handles fetching species and location data based on user interactions.

## Best Practices
### Scalable State Management:
- Centralized state handling in the Vuex store ensures scalability and ease of maintenance.

### Component Reusability:
- Used VueTailwind components for buttons, modals, and pagination, promoting consistent design and code reuse.

### Modular Codebase:
- Followed Nuxt’s modular architecture for better separation of concerns.


## Future Improvements
### Enhanced Error Handling:

- Create a reusable Error Alert component that accepts an error message as a prop and displays it gracefully.

### Utility Functions for Data Formatting:
- Add utility functions to standardize API response formatting (e.g., scientific_name → Scientific Name).

### Testing:

- Write component tests using @nuxt/test-utils for improved reliability and reduced regression.
### CI/CD Integration:

- Add GitHub Actions for linting, testing, and deployment pipelines.
### Improved Reactivity for Current Scientific ID:

- Debug and resolve the issue to ensure currentScientificId updates correctly when the user changes pages in the Location tab.
### Enhanced UI/UX:

- Add loading spinners for API calls.
- Improve tooltip designs for better user interaction

