# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname              | string | null: false |
| email                 | string | null: false, unique: true	|
| encrypted_password     | string | null: false |
| last_name               | string   | null: false |
| first_name              | string   | null: false |
| last_name_kana           | string   | null: false |
| first_name_kana          | string | null: false |
| birth_date              | date | null: false |

### Association

- has_many :items
- has_many :purchases



## purchases テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| user              | references | null: false, foreign_key: true |
| item              | references | null: false,foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :pay_form



## item テーブル

| Column             | Type               | Options     |
| ------------------ | ------------------ | ----------- |
| user                      | references           | null: false, foreign_key: true|
| product_name               | string                | null: false |
| info                      | text                 | null: false |
| category_id               | integer            | null: false | ActiveHash
| sales_status_id           |  integer          | null: false | ActiveHash
| shipping_fee_status_id      |  integer        | null: false | ActiveHash
| prefecture_id               |    integer        | null: false | ActiveHash
| scheduled_delivery_id        |  integer       | null: false | ActiveHash
| price                       |   integer       | null: false |


### Association

- belongs_to :user
- has_one    :purchase



## pay_form テーブル

| Column     | Type       | Options     |
| ---------- | ---------- | ------------|
| purchase             | references      | null: false, foreign_key: true |
| postal_code          | string         | null: false |
| prefecture_id           | integer        | null: false | ActiveHash
| city                  | string         | null: false |
| addresses              | string         | null: false |
| building              | string         |               |
| phone_number            | string         | null: false |
### Association

- belongs_to :purchase



