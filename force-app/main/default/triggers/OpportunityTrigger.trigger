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
                if (opp.Amount != null && opp.Amount < 5000) {
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
            OpportunityTriggerHelper.stopBankOppClose(Trigger.old);

        }
        when AFTER_INSERT {

        }
        when AFTER_UPDATE {
            /*
* When an opportunity is updated set the primary contact on the opportunity
* to the contact on the same account with the title of 'CEO'.
* Trigger should only fire on update.
*/
            /*
Trigger to update the primary contact on an opportunity when it is updated.
1. Define trigger on Opportunity for the before update event.
2. Create a set to store unique account IDs from the updated opportunities.
3. Loop through each opportunity in the trigger context:
   a. Check if the opportunity has an associated account ID.
   b. If it does, add the account ID to the set.
4. Query for contacts with the title 'CEO' for the collected account IDs.
5. Create a map to associate account IDs with their corresponding CEO contacts.
6. Loop through the queried contacts:
   a. For each contact, add it to the list of CEO contacts for its account ID in the map.
7. Loop through the opportunities again:
   a. For each opportunity, check if the account ID has any associated CEO contacts.
   b. If a CEO contact exists, set the primary contact field on the opportunity to the CEO contact's ID.
*/

            for (Opportunity opp: Trigger.new) {
                List<Contact> ceoTitle = [ SELECT Id, Name, Title FROM Contact WHERE Title = 'CEO'];

            }

        }
        when AFTER_DELETE {

        }
        when AFTER_UNDELETE {

        }
    }

}