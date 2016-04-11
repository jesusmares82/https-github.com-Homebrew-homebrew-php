require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Yaz < AbstractPhp53Extension
  init
  desc "This extension implements a Z39.50/SRU client for PHP using the YAZ toolkit and the ZOOM framework."
  homepage "http://www.indexdata.com/phpyaz"
  url "https://pecl.php.net/get/yaz-1.1.9.tgz"
  sha256 "9dd4da2fd6042b37a1811972134f852c94a6f6b85ca4ec5ed5d766eb27a6c401"
  revision 1

  bottle do
    sha256 "5d0e3691ff90cae813057cf7330bd68d9f8cd948b5df5c0e1a4ece15e42cdac8" => :el_capitan
    sha256 "d660db18851a117b3db1c92698b29fe634eeb0e1bd6bcc4c9d62cc7d5f76b922" => :yosemite
    sha256 "6a9f08dd45e007a015223cd7f47214e883917fe8d72ffd18a943608e86788968" => :mavericks
  end

  depends_on "yaz"

  def install
    Dir.chdir "yaz-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaz.so"
    write_config_file if build.with? "config-file"
  end
end
