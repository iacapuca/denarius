# Denarius

The **denarius** (Latin: [[deːˈnaːriʊs]](https://en.wikipedia.org/wiki/Help:IPA/Latin "Help:IPA/Latin"), pl. **dēnāriī** [[deːˈnaːriiː]](https://en.wikipedia.org/wiki/Help:IPA/Latin "Help:IPA/Latin")) was the standard [Roman](https://en.wikipedia.org/wiki/Ancient_Rome "Ancient Rome") silver coin from its introduction in the [Second Punic War](https://en.wikipedia.org/wiki/Second_Punic_War "Second Punic War") c. 211 BC^[[1]](https://en.wikipedia.org/wiki/Denarius#cite_note-1)^ to the reign of [Gordian III](https://en.wikipedia.org/wiki/Gordian_III "Gordian III") (AD 238–244), when it was gradually replaced by the [Antoninianus](https://en.wikipedia.org/wiki/Antoninianus "Antoninianus"). It continued to be minted in very small quantities, likely for ceremonial purposes, until and through the [tetrarchy](https://en.wikipedia.org/wiki/Tetrarchy "Tetrarchy") (293–313). ^[[2]](https://en.wikipedia.org/wiki/Denarius#cite_note-2)^ ^: 87 ^

The word _dēnārius_ is derived from the [Latin](https://en.wikipedia.org/wiki/Latin "Latin") _dēnī_ "containing ten", as its value was originally of 10 [assēs](<https://en.wikipedia.org/wiki/As_(coin)>) "As (coin)").^[[note 1]](https://en.wikipedia.org/wiki/Denarius#cite_note-3)^ The word for "money" descends from it in Italian ( _denaro_ ), Slovene ( _denar_ ), Portuguese ( _dinheiro_ ), and Spanish ( _dinero_ ). Its name also survives in the [dinar](https://en.wikipedia.org/wiki/Dinar "Dinar") currency.

Its symbol is represented in [Unicode](https://en.wikipedia.org/wiki/Unicode "Unicode") as 𐆖 (U+10196), however it can also be represented as X̶ (capital letter X with combining long stroke overlay).

## Requirements

To be able to run **Denarius** you will need to have **Docker** installed on your machine, the instructions to install Docker can be found [here
](https://docs.docker.com/engine/install/)Docker compose is also **required**[
](https://docs.docker.com/engine/install/)After installing Docker you will also need a **.env** file and **dev.secret.exs** files which store the env variables needed by the applications
A token to the[ ](https://docs.docker.com/engine/install/)[exchangeratesapi](https://exchangeratesapi.io/) is needed, so you will need to register and request a token.

## How to run

Clone the project

```
git clone https://github.com/iacapuca/denarius.git
```

Cd into the folder of the project

```
cd denarius
```

Run the docker compose command

```
docker compose up
```

TODO: running commands inside the container and applications will be runing at port 4040

## Endpoints

- List all transactions
  - GET
    - /transactions

```json
{
  "transactions": [
    {
      "amount": 531,
      "from": "EUR",
      "inserted_at": "2022-03-07T07:13:47",
      "rate": 1.087423,
      "to": "USD",
      "transaction_id": "fdb72efc-ebae-4f9d-b176-0f2b6dce7e45",
      "user_id": 1
    }
  ]
}
```

- Fetch all transactions by user_id
  - GET
    - /transactions/{user_id}

```json
{
  "transactions": [
    {
      "amount": 531,
      "from": "EUR",
      "inserted_at": "2022-03-07T07:13:47",
      "rate": 1.087423,
      "to": "USD",
      "transaction_id": "fdb72efc-ebae-4f9d-b176-0f2b6dce7e45",
      "user_id": 1
    }
  ]
}
```

- Convert currencies
  - GET
    - /convert?from={from}&to={to}&amount={amount}&user_id={user_id}
      - example:
        - /convert?from=EUR&to=USD&amount=100&user_id=1

```json
{
  "amount": 100,
  "converted_amount": 108.64259999999999,
  "datetime_utc": "2022-03-07T16:59:52.674572Z",
  "from": "EUR",
  "rate": 1.086426,
  "to": "USD",
  "user_id": 1
}
```
