require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xmldiff < AbstractPhp71Extension
  init
  desc "XML diff and merge"
  homepage "https://pecl.php.net/package/xmldiff"
  url "https://pecl.php.net/get/xmldiff-1.1.2.tgz"
  sha256 "03b6c4831122e2d8cf97cb9890f8e2b6ac2106861c908d411025de6f07f7abb1"

  def install
    Dir.chdir "xmldiff-#{version}"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/xmldiff.so"
    write_config_file if build.with? "config-file"
  end
end
