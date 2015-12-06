require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Yaz < AbstractPhp54Extension
  init
  desc "This extension implements a Z39.50/SRU client for PHP using the YAZ toolkit and the ZOOM framework."
  homepage "http://www.indexdata.com/phpyaz"
  url "https://pecl.php.net/get/yaz-1.1.6.tgz"
  sha256 "dd9b919ba3b2a09a9c77c847407f106512fe75979cc0689ebccef08c80719eee"

  bottle do
    sha256 "9f19cc8337e41dc45573608f9ccf6feab439f80ff7270877bcaaabe04f19db06" => :el_capitan
    sha256 "7bc76b6a6b83b42b2e19a8b0398e9bbd294d789cbe2bc22c8dbb1509f4383518" => :yosemite
    sha256 "31430ff5c456907597f9245a6897c7d05ea476a294c2f663673d6f9a53a9ab54" => :mavericks
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
