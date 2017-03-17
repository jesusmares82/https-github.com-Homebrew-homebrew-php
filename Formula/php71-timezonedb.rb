require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Timezonedb < AbstractPhp71Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2017.2.tgz"
  sha256 "e96ea4045a2886d68d15ad64e8d0ace1dd5287b08226e422bc7befb27944927a"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "335b8040a671b58b133ad1fe62f2edc223067c3c9fa84d26848d579a92c45aa6" => :sierra
    sha256 "4beb2e625521453e735dd794bc877f069e54db5e91afc756d1405ae77f209e5f" => :el_capitan
    sha256 "6d9ff50a09d943759a2a02c63f98c21e332b27b0e48efc2fb51d7e6ce44896e2" => :yosemite
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
