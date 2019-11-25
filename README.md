# Fintech

## Postgres

We need a username: postgres password: postgres to test this project

## Starting Phoenix server:

* Install dependencies with:

      mix deps.get

* Create and migrate your database with:

      mix ecto.setup

* Install Node.js dependencies with:

      cd assets && npm install

* Start Phoenix endpoint with:

      mix phx.server

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Purpose

The purpose of this project is to acquire knowledge in phoenix framework as well as also fulfill Pagantis technical test.

## Implementation

### Entities
#### Banks
This entity holds the representation for a bank.
#### Customers
This entity holds the representation for a customer from a bank.
#### Accounts
This entity holds the representation for an account from a customer.
#### Transferences
This entity holds the representation for a transference from an account.
### TransferAgent
#### Testing
* Test the transfer Agent with iex interface:

      'iex -S phx.server'
      '{:ok, _} = Fintech.TransferAgent.start_link([])'
      'alias Fintech.Transferences.Transference'
      'Fintech.TransferAgent.transfer({:intra, %Transference{account_id: 1, quantity: 100}})'

### Metrics
I listened to a recent podcast from [OvermindDL1](https://runninginproduction.com/podcast/1-a-medical-web-app-at-a-university-with-gabriel-robertson) a well known user from the Erlang/Elixir community, and core team member for: ldap_ex and permission_ex. He mentioned some useful tools one being telemetry from Erlang which I haven't used it since this same project.

I couldn’t imagine the setup for telemetry was that easy, the potential and configuration from this dependency is huge.

### Logging
I used Logger to perform the required logging for specific parts for the project.

### Deployment
I used distilery for deployment of this project. I haven't tested yet the new deployment system from elixir 1.9 but I would check it in the future for sure.
Also I would check out how to integrate docker with the distilery image.

* Walthrough:

    # start a shell, like 'iex -S mix'
    > _build/dev/rel/fintech/bin/fintech.bat console

    # start in the foreground, like 'mix run --no-halt'
    > _build/dev/rel/fintech/bin/fintech.bat foreground

    # start in the background, must be stopped with the 'stop' command
    > _build/dev/rel/fintech/bin/fintech.bat start

    If you started a release elsewhere, and wish to connect to it:

    # connects a local shell to the running node
    > _build/dev/rel/fintech/bin/fintech.bat remote_console

    # connects directly to the running node's console
    > _build/dev/rel/fintech/bin/fintech.bat attach

    For a complete listing of commands and their use:

    > _build/dev/rel/fintech/bin/fintech.bat help

### Docs
Never used exdocs in any of my personal project, but is really easy to use and not gonna lie it's awesome. Just by using documenting attributes in the project you can create this same documentation.

### Testing
I have added some extra validations for the entities changesets I have never used before. I had to comment some of the generated tests because I couldn't fix them. I haven't used ecto associations well enough. Also this whole project the main difficulty for me has been the ecto associations.

I never used doctests before and I tested some trivial functions because I didn't know how to test a database operating function. I found doctest really easy to setup and to integrate into the docs.

## Questions:
### How would you improve your solution? What would be the next steps?
My whole project can be improved in every technical area. I don't think I have the knowledge to say any of the areas I tried to implement are efficient enough or good enough. I still have a long journey into the Elixir path.

I still have to implement the money inyection into a second account. I will need to test the kind of approach database-wise I would follow to achieve that. One would be just adding the account id, and the other one would be with an association.

The next step would be to assign into the database the user. Although we can do transferences via iex and calling the GenServer, it would be really nice to do transferences from the transference new view from phoenix. However we first need to assign the user into the actual phoenix conn.

I have done previously a project using github oauth [The-Complete-Elixir-and-Phoenix-Bootcamp](https://github.com/kamigari/The-Complete-Elixir-and-Phoenix-Bootcamp) related but not the solution we need. We would rather need a login form and assign that user into the phoenix connection.
### After implementation, is there any design decision that you would have done differently?
We could create another entity: transaction. This will be in charge of doing the micro transferences from a single transference when a full transference is out of the established scope.
### How would you adapt your solution if transfers are not instantaneous?
I would use the GenServer that I created on the Transfer Agent and use the state to save the state of the transferences being taken place. This solution would use an existing implementation. In one hand we could reimplement the solution by using a cached solution using cachex, which is based by ETS and was also highlighted by [OvermindDL1](https://runninginproduction.com/podcast/1-a-medical-web-app-at-a-university-with-gabriel-robertson), if we are in need of a faster solution. On the other hand we can use a disk based solution if we aren't in the need of window of response, this would be implementing a disk based batch for night execution.

## Disclaimer
I have an exam on 28 of november, so I can’t work any further into this project. The most time consuming part from this technical test was ecto associations and how to work with them. The remaining parts were also hard because was the first time I had used them but I found it fairly easy to make them working.

This project was done during the weekend from the spare hours I could get from studying and working from my second job as waiter for 'El mentidero de la villa'.

## Prerequisites

* To run this project you need:
* Erlang: The programming language http://www.erlang.org/
* Elixir: The programming language https://elixir-lang.org/

## Built within

* Elixir: The programming language https://elixir-lang.org/
* Phoenix: Web framework in Elixir http://www.phoenixframework.org/

## Authors

* **Alberto Revuelta Arribas** - *initial work*  [kamigari](https://github.com/kamigari)

## License

* This project is licensed under the License - see the [LICENSE.md](LICENSE.md) file for details.
