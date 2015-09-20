class PhpInstall < Formula
  desc "Install different versions of php"
  homepage "https://github.com/marcosdsanchez/php-install#readme"
  url "https://github.com/marcosdsanchez/php-install/archive/v0.0.1.tar.gz"
  sha256 "97f1124ca0b200234dce4bec307e153768f803c08768a231ed3a3ff2864c36c3"
  head "https://github.com/marcosdsanchez/php-install.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "dd34d219e395f8b5915f9a576fdc2047faf4905ef75edc42976cf34d801c5d33" => :el_capitan
    sha256 "f8b4eba89817efeb6a0f8d2392b92900fb383972911ce618a49565cd898d9ab8" => :yosemite
    sha256 "2607de6bd672f4f264fa74d68ec65b2416c29f6e739664548ed049389783f207" => :mavericks
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "php-install"
  end
end
