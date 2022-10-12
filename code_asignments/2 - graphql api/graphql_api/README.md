# Graphql API Assignment

## Notes

**Create User Mutation**
1. The only validation that is done is that if the `id` provided already exists. If this is the case, then an error is returned.
2. If one of the 3 preferences are not included in the query on GraphQL, then the value will be null (not value will be setted by defect).