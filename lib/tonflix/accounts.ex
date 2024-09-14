defmodule Tonflix.Accounts do
  use Ash.Domain

  resources do
    resource Tonflix.Accounts.User
  end
end
