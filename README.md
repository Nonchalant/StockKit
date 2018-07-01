# StockKit

<img src="https://github.com/Nonchalant/StockKit/blob/master/Documents/stock_kit.png">

## Prepare

```
// conf.yml

slack:
    token: <SLACK_BOT_TOKEN>
    channel: <CHANNEL_NAME>
    username: <BOT_NAME>
stocks:
  - code: <STOCK_CODE>
    name: <COMPANY_NAME>
    amount: <AMOUNT_OF_STOCK>
    purchasedPrice: <PURCHASED_PRICE>
  - code: <STOCK_CODE>
    name: <COMPANY_NAME>
    amount: <AMOUNT_OF_STOCK>
    purchasedPrice: <PURCHASED_PRICE>
  - ...
```

## Requirements

- [Docker](https://www.docker.com/)

## Usage

```
$ make build
$ make run
```
