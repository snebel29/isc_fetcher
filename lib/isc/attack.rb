module ISC
  class Attack

    def initialize(options)
      @cli_options = options
    end

    def fetch
      limit = @cli_options[:limit].to_s
      date = now_utc_date
      response = HTTParty.get("https://isc.sans.edu/api/sources/attacks/#{limit}/#{date}/handler?json")
      attacks = JSON.load(response.body)
      file_content = to_csv(attacks)
      write_to_file(file_content, 'attacks.csv')
    end

    def to_csv(json)
      csv = []
      csv << 'ip,attacks,count,firstseen,lastseen'
      json.each do |row|
        csv << clean_ip(row['ip']) + ',' + row['attacks'].to_s + ',' + row['count'].to_s + ',' + row['firstseen'].to_s + ',' + row['lastseen'].to_s
      end
      file = ''
      csv.each {|l| file += "#{l}\n"}
      return file
    end

    def write_to_file(csv, file)
      File.open(file, 'w') {|f| f.write(csv)}
      puts "Write to file #{file}"
    end

    def clean_ip(raw_ip)
      clean_ip = []
      raw_ip.split('.').each do |octet|
        clean_ip << octet.to_i
      end
      clean_ip.join('.')
    end

    private
    def now_utc_date
      Time.now.utc.strftime('%Y-%m-%d')
    end
  end
end