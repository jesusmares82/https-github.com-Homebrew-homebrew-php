require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Leveldb < AbstractPhp53Extension
  init
  desc "This extension is a PHP binding for Google LevelDB"
  homepage "https://pecl.php.net/package/leveldb"
  url "https://pecl.php.net/get/leveldb-0.1.4.tgz"
  sha256 "b0d2485e7f1353a794cd58bbaf331154723cda98ae41757f1167e1661bd78eef"
  head "https://github.com/reeze/php-leveldb.git"

  bottle do
    cellar :any
    sha256 "0b0cb21a7b061bc35d6f9c259bc826e6224e5101d9a6016a64f88df576e35fae" => :el_capitan
    sha256 "c6d61192bca3d2666350a0bcc4be409363e102cb5377c6e7569563cfd274a457" => :yosemite
    sha256 "a4eff63a09ed9dc3a4960e78e7866a060ce5f7c85239b855971d84b197f79aa8" => :mavericks
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
