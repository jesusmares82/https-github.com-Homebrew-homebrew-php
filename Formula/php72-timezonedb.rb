require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Timezonedb < AbstractPhp72Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2017.2.tgz"
  sha256 "e96ea4045a2886d68d15ad64e8d0ace1dd5287b08226e422bc7befb27944927a"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "89234bda9ef1ee4c4e6ab359673412b2ad5611bfba12d8f8baeedbac9ad1ec66" => :sierra
    sha256 "443f65a5eb19c6f910925a792c17d5ddd2f17c36c5a7d285d66abd9a7f0fb9b3" => :el_capitan
    sha256 "6551365157449433dfd630996879d4fd98b2cdfffb958896441a70cb4622dcd2" => :yosemite
  end

  def install
    Dir.chdir "timezonedb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/timezonedb.so"
    write_config_file if build.with? "config-file"
  end
end
