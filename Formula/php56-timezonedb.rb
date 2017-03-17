require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Timezonedb < AbstractPhp56Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2017.2.tgz"
  sha256 "e96ea4045a2886d68d15ad64e8d0ace1dd5287b08226e422bc7befb27944927a"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "236a0f1fd920b3478f30ed437ed530bb90e12ee32cfdd3f7e692c98f694531f4" => :sierra
    sha256 "74ce0a291e91516fd20e01a60f7deefd7496d42183cf813deb3e2eee771a392b" => :el_capitan
    sha256 "a1d71f3fba0d303155d884b5f283a442e6c1a92e5d1ad72f2606520b6821bbb1" => :yosemite
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
