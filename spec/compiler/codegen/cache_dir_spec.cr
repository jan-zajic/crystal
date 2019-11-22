require "../../spec_helper"

describe "Crystal:CacheDir" do
  describe "directory_for" do
    dir = CacheDir.instance
    puts dir.directory_for("C:\\tmp/hello.cr")
  end
end
