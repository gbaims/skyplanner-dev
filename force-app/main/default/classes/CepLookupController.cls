// This Class represents the Composition Root 
public with sharing class CepLookupController {
    public CepLookupController() {

    }

    @AuraEnabled
    public static BrazillianAddress searchAddress(string lookupCep){
        // TODO: Sanitize and validate lookupCep

        // TODO: get Endpoint from configuration
        String endpoint = 'https://viacep.com.br/ws/{0}/json';
        ViaCepMapper mapper = new ViaCepMapper();
        ViaCepGateway gateway = new ViaCepGateway(mapper, endpoint);

        BrazillianAddress address;
        try {
            address = gateway.getAddress(lookupCep);
        } catch (CalloutException e) {
            throw e;
        } catch (BadRequestException e) {
            throw e;
        } catch (ViaCepServerException e) {
            throw e;
        } catch (NonExistentCepException e) {
            throw e;
        } catch (Exception e) {
            throw e;
        } 

        return address;
    }
}