defmodule Tonflix.Accounts.User do
  use Ash.Resource, otp_app: :tonflix, domain: Tonflix.Accounts, data_layer: AshPostgres.DataLayer

  postgres do
    table "users"
    repo Tonflix.Repo
  end

  actions do
    defaults [
      :read,
      :destroy,
      create: [
        :email,
        :first_name,
        :last_name,
        :gender,
        :honorific_title,
        :street,
        :zip_code,
        :country,
        :birthdate,
        :mobile_phone_number
      ],
      update: [
        :email,
        :first_name,
        :last_name,
        :gender,
        :honorific_title,
        :street,
        :zip_code,
        :country,
        :birthdate,
        :mobile_phone_number
      ]
    ]
  end

  attributes do
    uuid_primary_key :id

    attribute :email, :string do
      allow_nil? false
      public? true
    end

    attribute :hashed_password, :string do
      # allow_nil? false
    end

    attribute :first_name, :string do
      allow_nil? false
      public? true
    end

    attribute :last_name, :string do
      allow_nil? false
      public? true
    end

    attribute :gender, :string do
      allow_nil? false
      public? true
    end

    attribute :honorific_title, :string do
      public? true
    end

    attribute :street, :string do
      allow_nil? false
      public? true
    end

    attribute :zip_code, :string do
      allow_nil? false
      public? true
    end

    attribute :country, :string do
      allow_nil? false
      public? true
    end

    attribute :birthdate, :date do
      allow_nil? false
      public? true
    end

    attribute :mobile_phone_number, :string do
      allow_nil? false
      public? true
    end

    timestamps()
  end
end
