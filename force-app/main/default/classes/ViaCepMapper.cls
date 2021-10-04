public with sharing class ViaCepMapper {
    public ViaCepMapper() {

    }

    // TODO: Deserialize to a DTO (not created yet) and then map manually
	public BrazillianAddress fromJson(String json) {
		return (BrazillianAddress) System.JSON.deserialize(json, BrazillianAddress.class);
	}
    
}
