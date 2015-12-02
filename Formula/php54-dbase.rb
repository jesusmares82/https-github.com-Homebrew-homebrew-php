require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Dbase < AbstractPhp54Extension
  init
  desc "dBase database file access functions"
  homepage "https://pecl.php.net/package/dbase"
  url "https://pecl.php.net/get/dbase-5.1.0.tgz"
  sha256 "20d6a40fb2efe4a06f503ec53512d02d71ceda87eac1f55208d7b5398f287a97"
  head "https://svn.php.net/repository/pecl/dbase/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "7e1c5ed22fec861422fb5c9cd849d1dccbc70ff360bcb774f88442b8ed57fb6a" => :el_capitan
    sha256 "96b742a23ec2e804ecccf38843797e7cc80ac7c64962c7333bc3ed40b4cbdaf9" => :yosemite
    sha256 "2bb92d6face108044305261b2d0732c770996ae4ac1c323802843e52483ed25c" => :mavericks
  end

  def install
    Dir.chdir "dbase-5.1.0"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}"

    system "make"
    prefix.install "modules/dbase.so"
    write_config_file if build.with? "config-file"
  end
end
