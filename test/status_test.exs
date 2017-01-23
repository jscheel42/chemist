defmodule StatusTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Status
      
  test "Return shards" do
    { :ok, shards } = shards()
    
    first_shard = List.first(shards)
    
    assert Map.has_key?(first_shard, "hostname")
  end
  
  test "Return shard" do
    region = "oce"
    
    { :ok, shard } = shard(region)
    
    assert Map.has_key?(shard, "hostname")
  end
  
end
