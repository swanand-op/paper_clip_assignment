import 'dart:convert';
import 'package:http/http.dart' as http;

class APICalls {

  Future<Map> fetchCompany() async{
    Map companyInfo = {};
    http.Response response = await http.get(Uri.parse('https://api.stockedge.com/Api/SecurityDashboardApi/GetCompanyEquityInfoForSecurity/5051?lang=en'));
    if(response.statusCode == 200) {
      String jsonString = response.body;
      var data = jsonDecode(jsonString);
      companyInfo = data;
    }
    print(companyInfo);
    return companyInfo;
  }

  Future<List<Map>> fetchPerformance() async{
    List<Map> companyPerformance = [];
    http.Response response = await http.get(Uri.parse('https://api.stockedge.com/Api/SecurityDashboardApi/GetTechnicalPerformanceBenchmarkForSecurity/5051?lang=en'));
    if(response.statusCode == 200) {
      String jsonString = response.body;
      List data = jsonDecode(jsonString);
      companyPerformance = data.cast<Map>();
    }
    print(companyPerformance);
    return companyPerformance;
  }
  
}

class Company {
  final String id, security, industryId, industry, sectorId, sector, mCap, ev, evDateEnd, bookNavPerShare, ttmpe, ttmpYearEnd, yeald, yearEnd, sectorSlug, industrySlug, securitySlug, pegRatio;
  Company(this.id, this.security, this.industryId, this.industry, this.sectorId, this.sector, this.mCap, this.ev, this.evDateEnd, this.bookNavPerShare, this.ttmpe, this.ttmpYearEnd, this.yeald, this.yearEnd, this.sectorSlug, this.industrySlug, this.securitySlug, this.pegRatio);
}