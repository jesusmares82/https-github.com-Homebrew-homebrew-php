require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Leveldb < AbstractPhp56Extension
  init
  homepage 'https://pecl.php.net/package/leveldb'
  url 'https://pecl.php.net/get/leveldb-0.1.4.tgz'
  sha256 'b0d2485e7f1353a794cd58bbaf331154723cda98ae41757f1167e1661bd78eef'
  head 'https://github.com/reeze/php-leveldb.git'

  bottle do
    cellar :any
    sha256 "e6e21ed4e95cae2592ba1064e286847e2d26060aaa1a30d273735661a88d9c7c" => :yosemite
    sha256 "c397595c966c34248ce73086f6398d0bf430fe637ec35f98b926a453a3e7e42f" => :mavericks
  end

  depends_on 'leveldb'

  def install
    Dir.chdir "leveldb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-leveldb=#{Formula['leveldb'].opt_prefix}"

    safe_phpize
    system "./configure", *args
    system "make"
    prefix.install "modules/leveldb.so"
    write_config_file if build.with? "config-file"
  end
end
