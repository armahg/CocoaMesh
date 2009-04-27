//
//  WebTestConstants.h
//  WebTest
//
//  Created by George  Armah on 3/8/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringToURLMappings.h"

#define LiveLoginURL @"http://login.live.com/"
#define SecureLiveLoginURL @"htpps://login.live.com/"
#define LiveSOAPURLEndPoint @"https://dev.login.live.com/wstlogin.srf"
#define LiveFXDomain @"user-ctp.windows.net"
#define LiveFXBaseURI @"https://user-ctp.windows.net"
#define LiveMeshBaseURI @"https://user-ctp.windows.net/V0.1/"
#define LiveFXMeshObjectsURI @"https://user-ctp.windows.net/V0.1/Mesh/MeshObjects/UICFO4FJCPQU5CLZ3SLHA73UUY"

/*Needs the following in this order
 applicationID
 loginendpoint
 rnd (random number)
 username
 password
 currenttime
 expirationtime
 */
#define LiveFrameworkSOAPTemplate			@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n \
<s:Envelope xmlns:s=\"http://www.w3.org/2003/05/soap-envelope\"\n \
xmlns:wsse=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\"\n \
xmlns:saml=\"urn:oasis:names:tc:SAML:1.0:assertion\"\n \
xmlns:wsp=\"http://schemas.xmlsoap.org/ws/2004/09/policy\"\n \
xmlns:wsu=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd\"\n \
xmlns:wsa=\"http://www.w3.org/2005/08/addressing\"\n \
xmlns:wssc=\"http://schemas.xmlsoap.org/ws/2005/02/sc\"\n \
xmlns:wst=\"http://schemas.xmlsoap.org/ws/2005/02/trust\">\n \
<s:Header> \
<wlid:ClientInfo xmlns:wlid=\"http://schemas.microsoft.com/wlid\">\n \
<wlid:ApplicationID>%@</wlid:ApplicationID>\n \
</wlid:ClientInfo> \
<wsa:Action s:mustUnderstand=\"1\">http://schemas.xmlsoap.org/ws/2005/02/trust/RST/Issue</wsa:Action>\n \
<wsa:To s:mustUnderstand=\"1\">%@</wsa:To>\n \
<wsa:MessageID>%@</wsa:MessageID>\n \
<wsse:Security>\n \
<wsse:UsernameToken wsu:Id=\"user\">\n \
<wsse:Username>%@</wsse:Username>\n \
<wsse:Password>%@</wsse:Password>\n \
</wsse:UsernameToken>\n \
<wsu:Timestamp Id=\"Timestamp\">\n \
<wsu:Created>%@</wsu:Created>\n \
<wsu:Expires>%@</wsu:Expires>\n \
</wsu:Timestamp>\n \
</wsse:Security>\n \
</s:Header>\n \
<s:Body>\n \
<wst:RequestSecurityToken Id=\"RST0\">\n \
<wst:RequestType>http://schemas.xmlsoap.org/ws/2005/02/trust/Issue</wst:RequestType>\n \
<wsp:AppliesTo>\n \
<wsa:EndpointReference>\n \
<wsa:Address>%@</wsa:Address>\n \
</wsa:EndpointReference>\n \
</wsp:AppliesTo>\n \
<wsp:PolicyReference URI=\"MBI\"></wsp:PolicyReference>\n \
</wst:RequestSecurityToken>\n \
</s:Body>\n \
</s:Envelope>"



/*Needs only
 username
 password
 */

#define WindowsLiveIDLoginSOAPEndPoint	@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\
<s:Envelope\n \
xmlns:s = \"http://www.w3.org/2003/05/soap-envelope\"\n \
xmlns:wsse = \"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\"\n \
xmlns:saml = \"urn:oasis:names:tc:SAML:1.0:assertion\"\n \
xmlns:wsp = \"http://schemas.xmlsoap.org/ws/2004/09/policy\"\n \
xmlns:wsu = \"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd\"\n \
xmlns:wsa = \"http://www.w3.org/2005/08/addressing\"\n \
xmlns:wssc = \"http://schemas.xmlsoap.org/ws/2005/02/sc\"\n \
xmlns:wst = \"http://schemas.xmlsoap.org/ws/2005/02/trust\">\n \
<s:Header>\n \
<wlid:ClientInfo xmlns:wlid = \"http://schemas.microsoft.com/wlid\">\n \
<wlid:ApplicationID>\"%@\"</wlid:ApplicationID>\n \
</wlid:ClientInfo>\n \
<wsa:Action s:mustUnderstand = \"1\">http://schemas.xmlsoap.org/ws/2005/02/trust/RST/Issue</wsa:Action>\n \
<wsa:To s:mustUnderstand = \"1\">https://dev.login.live.com/wstlogin.srf</wsa:To>\n \
<wsse:Security>\n \
<wsse:UsernameToken wsu:Id = \"user\">\n \
<wsse:Username>%@</wsse:Username>\n \
<wsse:Password>%@</wsse:Password>\n \
</wsse:UsernameToken>\n \
</wsse:Security>\n \
</s:Header>\n \
<s:Body>\n \
<wst:RequestSecurityToken Id =\"RST0\">\n \
<wst:RequestType>http://schemas.xmlsoap.org/ws/2005/02/trust/Issue</wst:RequestType>\n \
<wsp:AppliesTo>\n \
<wsa:EndpointReference>\n \
<wsa:Address>http://live.com</wsa:Address>\n \
</wsa:EndpointReference>\n \
</wsp:AppliesTo>\n \
<wsp:PolicyReference URI = \"MBI\"></wsp:PolicyReference>\n \
</wst:RequestSecurityToken>\n \
</s:Body>\n \
</s:Envelope>"

#define ACCEPT @"Accept"
#define CONTEN_TYPE @"Content-Type"
#define SOAP_ACTION @""
#define CONTENT_LENGTH @"Content-Length"
#define USER_AGENT @"User-Agent"
#define HOST @"Host"
#define HTTP_POST @"POST"
#define APP_ID @"\"000000004C00D592\""
#define HTTP_GET @"GET"
#define HTTP_PUT @"PUT"
#define HTTP_AUTHORIZATION @"Authorization"
#define BaseURI @"BaseUri"
#define HTTP_OPTIONS @"OPTIONS"
#define SELFLINK @"SelfLink"


#define USERID @"userid"
#define PASSWORD @"pwd"
#define DELEGATE @"delegate"



#define BINARYTOKEN @"wsse:BinarySecurityToken"
#define CONTACTS @"ContactsLink"
#define CONTACTSLINK @"ContactsLink"
#define MESHLINK @"Mesh"
#define MESH @"Mesh"
#define SCRIPTLINK @"Script"
#define SCRIPT @"Script"
#define PROFILESLINK @"ProfilesLink"
#define PROFILES @"ProfilesLink"
#define ENTRIES @"Entries"

#define CONTACTSNUM 0
#define MESHNUM 1
#define SCRIPTNUM 2
#define PROFILESNUM 3
#define MESHOBJECTSNUM 4


#define RESOURCEDATA @"resourceData"

