require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Timezonedb < AbstractPhp53Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2017.2.tgz"
  sha256 "e96ea4045a2886d68d15ad64e8d0ace1dd5287b08226e422bc7befb27944927a"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "5f9fce4edf088620731ab4544f30ea623bb62f7e375a3570c32be8b0f49e2171" => :sierra
    sha256 "1ef0b6979b1c67dda2a4315f65648856bc90ee32cf286d71d733164955a7fca2" => :el_capitan
    sha256 "32ef4682094b7db16c4c732322af3e034b5b277233d0e0ba931bb9eff090e253" => :yosemite
  end

  def install
    Dir.chdir "timezonedb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/timezonedb.so"
    write_config_file if build.with? "config-file"
  end
end
