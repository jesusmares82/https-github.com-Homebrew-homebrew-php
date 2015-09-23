require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Leveldb < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/leveldb"
  url "https://pecl.php.net/get/leveldb-0.1.4.tgz"
  sha256 "b0d2485e7f1353a794cd58bbaf331154723cda98ae41757f1167e1661bd78eef"
  head "https://github.com/reeze/php-leveldb.git"

  bottle do
    cellar :any
    sha256 "5582e254beeba57d03c6ec7400586455feac257282b3091cd07b6dbc8f08308e" => :el_capitan
    sha256 "c990d38b617cafad645487cba517e11afdf7bd516c40653daf7ff4ceae0f5673" => :yosemite
    sha256 "d6b39009588cc85a727f938b94bd3b47c059d9d0bab9452c3a33103a4dd2d31e" => :mavericks
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
