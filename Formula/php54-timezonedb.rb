require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Timezonedb < AbstractPhp54Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2017.2.tgz"
  sha256 "e96ea4045a2886d68d15ad64e8d0ace1dd5287b08226e422bc7befb27944927a"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "7c9be05e8cab1e09dc23cfc4095919a7a3a2ef304ffe8a32c4a2b24085ad73cb" => :sierra
    sha256 "b0020b63685dea3836fe53c4207c1d19a7abc401f31cacdff142e68acec61d06" => :el_capitan
    sha256 "d083c5eaeb7b83badd70e9d11274ad5a5d04af597a8ca34b136a65ef72db459e" => :yosemite
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
