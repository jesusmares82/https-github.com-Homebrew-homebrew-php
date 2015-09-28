require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Leveldb < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/leveldb"
  url "https://pecl.php.net/get/leveldb-0.1.4.tgz"
  sha256 "b0d2485e7f1353a794cd58bbaf331154723cda98ae41757f1167e1661bd78eef"
  head "https://github.com/reeze/php-leveldb.git"

  bottle do
    cellar :any
    sha256 "4909c72be3f8c38a36b50d52ef38c462570fd5305bee7c78d50e26087ab46522" => :el_capitan
    sha256 "137615c11b5f1256b5e0d96fe019044ba0f7421e6e86206d5f7e81a75b839707" => :yosemite
    sha256 "4a2802b50e8fdad5f542926a76c48cf6b6e1722498509047e20652ea195d476c" => :mavericks
  end

  depends_on "leveldb"

  def install
    Dir.chdir "leveldb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-leveldb=#{Formula["leveldb"].opt_prefix}"

    safe_phpize
    system "./configure", *args
    system "make"
    prefix.install "modules/leveldb.so"
    write_config_file if build.with? "config-file"
  end
end
