
defmodule Gradely.Organizations do
    alias Gradely.Repo
    alias Gradely.Organizations.Organization

    def get_organization!(id) do
        Repo.get!(Organization, id)
    end

end