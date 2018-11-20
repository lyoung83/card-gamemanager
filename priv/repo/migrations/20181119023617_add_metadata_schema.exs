defmodule GameManager.Repo.Migrations.AddMetadataSchema do
  use Ecto.Migration

  def change do
    create table("metadata") do
      add :data, :map
    end
  end
end
