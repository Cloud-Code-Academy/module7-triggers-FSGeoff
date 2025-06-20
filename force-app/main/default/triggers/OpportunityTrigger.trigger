/**
 * Created by geoffreynix on 6/19/25.
 */

trigger OpportunityTrigger on Opportunity (before insert, before update, after insert, after update, before delete, after delete, after undelete) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
        }
        when BEFORE_UPDATE {
            /*
* When an opportunity is updated validate that the amount is greater than 5000.
* Error Message: 'Opportunity amount must be greater than 5000'
* Trigger should only fire on update.
*/
            for(Opportunity opp: Trigger.new) {
                if (opp.Amount < 5000) {
                    opp.addError('Opportunity amount must be greater than 5000');
                }
            }

        }
        when BEFORE_DELETE {
            /*
 * When an opportunity is deleted prevent the deletion of a closed won opportunity if the account industry is 'Banking'.
 * Error Message: 'Cannot delete closed opportunity for a banking account that is won'
 * Trigger should only fire on delete.
 */
            for (Opportunity opp: Trigger.old) {
                if (opp.StageName == 'Closed Won' && opp.Account.Industry == 'Banking') {
                    opp.addError('Cannot delete closed opportunity for a banking account that is won');
                }
            }

        }
        when AFTER_INSERT {

        }
        when AFTER_UPDATE {
            /*
* When an opportunity is updated set the primary contact on the opportunity
* to the contact on the same account with the title of 'CEO'.
* Trigger should only fire on update.
*/
            for (Opportunity opp: Trigger.new) {
                List<Contact> con = [ SELECT Id, Name, Title FROM Contact WHERE Title = 'CEO'];
               // opp.Contact = con[0].AccountId.;
            }

        }
        when AFTER_DELETE {

        }
        when AFTER_UNDELETE {

        }
    }

}