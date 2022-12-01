# Graphql API Assignment

## Notes
Here I include some comments about how I solved some parts of the code assignments, and also some problems that
I'm having on some parts.

**Users Query**

I couldn´t figure out a way to avoid making the pattern matching of all the combinations of the user's preferences, 
so in the module `GraphqlApiWeb.User` I included all the possible combinations of the fields `likesEmails`, `likesPhoneCalls`, and `likesFaxes`.


**Create User Mutation**
1. The only validation that is done is if the id provided already exists. If this is the case, then an error is returned.
2. If one of the 3 preferences is not included in the query on GraphQL, then the value will be null (no value will be set by default).

**Update User Preferences Mutation**

The preference field that is not present on Graphql, will be null after the update (I couldn´t figure out how to keep the boolean value of the not given preference field).

**Create User Subscription Mutation**

For some reason that I couldn't figure out, after setting up all the steps to have up and running a subscription, 
If I execute the subscription on a tab on GraphiQL, and after that, I execute the create user mutation, 
then I don´t see anything on the subscription tab. I added some loggers to the subscription and seems to work fine, 
but nothing is shown on the subscription on Graphiql. I followed these links but without luck:
https://hexdocs.pm/absinthe/Absinthe.Subscription.html
https://blog.grio.com/2021/06/graphql-subscription-using-absinthe.html
https://nts.strzibny.name/graphql-subscriptions-with-elixir-and-absinth/

**Update User Preferences Subscription**

I have the same issue as the Create User Subscription Mutation.


alias GraphqlApi.Accounts.{Preference, User}
alias GraphqlApi.Repo
import Ecto.Query

query = from p in "preferences",
where: p.likes_emails == true
select: p.likes_emails

Repo.all(query)