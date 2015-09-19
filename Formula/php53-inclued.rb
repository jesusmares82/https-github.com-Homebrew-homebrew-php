require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Inclued < AbstractPhp53Extension
  init
  homepage 'https://pecl.php.net/package/inclued'
  url 'https://pecl.php.net/get/inclued-0.1.3.tgz'
  sha256 '89d7324b164b739b53d5290c7ec99d8e05522e76db0885bda4b4a693113b4a28'
  head 'https://svn.php.net/repository/pecl/inclued/trunk'

  bottle do
    cellar :any_skip_relocation
    sha256 "aae8abcda3e0af81b0be4ea3c8b7a5786aa4a718165e52a7b7e1a2839454c1ed" => :el_capitan
    sha256 "7ed3a88146b4b71d324c29d8790fb41862b9337f051c89189840053410924307" => :yosemite
    sha256 "1f972ec211dfb06e5e71af61e5d59e992d437491c41b01b225d7934728be16de" => :mavericks
  end

  def install
    Dir.chdir "inclued-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/inclued.so"
    write_config_file if build.with? "config-file"
  end
end
