defmodule Events.CustomersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Events.Customers` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        phone: "some phone",
        status: "some status"
      })
      |> Events.Customers.create_customer()

    customer
  end
end
