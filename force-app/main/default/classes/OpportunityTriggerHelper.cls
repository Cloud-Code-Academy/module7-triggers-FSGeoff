/**
 * Created by geoffreynix on 6/20/25.
 */

public with sharing class OpportunityTriggerHelper {
    public static void stopBankOppClose(List<Opportunity> oldOpps) {
        for (Opportunity opp: oldOpps) {
            if (opp.StageName == 'Closed Won' && opp.Account.Industry == 'Banking') {
                opp.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }
}