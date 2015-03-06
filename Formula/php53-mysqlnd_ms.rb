require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53MysqlndMs < AbstractPhp53Extension
  init
  homepage "http://pecl.php.net/package/mysqlnd_ms"
  url "http://pecl.php.net/get/mysqlnd_ms-1.5.2.tgz"
  sha1 "b7b3ddd1f40ffec75a48456edf053c28fc5aad83"
  head "https://svn.php.net/repository/pecl/mysqlnd_ms/trunk/"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "2d952f04416340ba83115854ae0f34b61a5eb6f7eb2de67901fca6d998ae6d0e" => :yosemite
    sha256 "89d190eaa26aa474c77fe63db63948ddce74fc5815ca95888e9910b5dd4724d1" => :mavericks
    sha256 "16bdb614b7bbfcb7afe2ec270aa346417887658c8264254df1f6e6dba4aba289" => :mountain_lion
  end

  def extension
    "mysqlnd_ms"
  end

  def install
    Dir.chdir extension + "-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mysqlnd-ms"

    system "make"
    prefix.install "modules/" + extension + ".so"
    write_config_file if build.with? "config-file"
  end
end
