#Author: shivanand.chachadi@delta.com
# Demo on karate framework using API calls.

@tag
Feature: 
  I want demo REST API methods using karate framework.
Background:
  	 * configure ssl = true
     * url baseUrl
     * def voucher_api_path = 'voucher_request.json'
		 * def header_path = 'headers.json'
		 * def putreqbody_path = 'putreqbody.json'
		 * def patchreqbody_path = 'patchreqbody.json'
		 * def soapreq_path = 'xmlRequest.txt'
 
  @postcall
  Scenario Outline: API call demo-POST Request
  * def voucher_request = read(voucher_api_path)
  * def headers_req = read(header_path)
  * configure headers = headers_req
  
    Given path '/ebanking/voucher/v1/vouchers'
    And request voucher_request
    When method post
    Then status <StatusCode>
    And print response
    And print applicationId
    And match $.vouchers[0].voucherStatus == <voucherStatus>
 
    
    Examples:
    |StatusCode|voucherStatus|
    |200|"REDEEMED"|
    |200|"Success"|

#-------------------------------------------------------------------
@getcall
Scenario: API call demo-GET Request
Given path '/actuator/health'
When method get
Then status 200
And print response
And match $.components.readinessState.status == 'UP'
 
#---------------------------------------------------------------------
@putcall
Scenario Outline: API call demo-Put Request  

* def putreqbody = read(putreqbody_path)

Given url 'https://reqres.in/api/users/2'
And request putreqbody
When method put
Then status <StatusCode>
And print response
And match $.name == <name>
And match response.name == '#present'
Examples: 
|StatusCode|name       |
|200			 |'Shivanand'|
|200       |'Shivanand'|
 
#---------------------------------------------------------------------
@patchcall
Scenario Outline: API call demo-Patch Request  

* def patchreqbody = read(patchreqbody_path)

Given url 'https://reqres.in/api/users/2'
And request patchreqbody
When method patch
Then status <StatusCode>
And print response
And match $.name == <name>
Examples: 
|StatusCode|name                |
|200       |'Shivanand Chachadi'|

#-----------------------------------------------------------------------
@deletecall
Scenario: API call demo-Delete Request

Given url 'https://reqres.in/api/users/2'
When method delete
Then status 204
And print response

#------------------------------------------------------------------------
@Soapcall
Scenario: Soap call -POST request

* def soapreq = read(soapreq_path)


Given url 'http://webservices1-st.delta.com:33524/equipment'
And request soapreq
When method post 
Then status 200
* def tem = /Envelope/Body/RetrieveIndustryAircraftTypesResponse/IndustryAircraftTypesResponse
* def noOfIndustryStdAircraftTypes_soapapi = tem.length
* print 'Size from SOAP API is', noOfIndustryStdAircraftTypes_soapapi

#--------------------------------------------------------------------------

@csvdata
Scenario Outline: 
Given url 'https://petstore.swagger.io/v2'
And path 'pet',id
When method GET
Then status 404 
And match $.message == Message
And print 'id is = ' + id, 'And error message is ' + Message
Examples:
|read('data.csv')|    
