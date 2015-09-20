class PhpInstall < Formula
  desc "Install different versions of php"
  homepage "https://github.com/marcosdsanchez/php-install#readme"
  url "https://github.com/marcosdsanchez/php-install/archive/v0.0.1.tar.gz"
  sha256 "97f1124ca0b200234dce4bec307e153768f803c08768a231ed3a3ff2864c36c3"
  head "https://github.com/marcosdsanchez/php-install.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "cec4ce33c201cca12f65b5ba80e5dbd0e83579124229d022966f6fa46a50e798" => :el_capitan
    sha256 "5c6cc927d691a707d1d5810a3962a55eb3b581df41e314d6766b0a1d02e31570" => :yosemite
    sha256 "c7b8fd35a0867175e1090a2690ca9ff613acc11665cb748d18bfa6940df4f0d7" => :mavericks
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "php-install"
  end
end
