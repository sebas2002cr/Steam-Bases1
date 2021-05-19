import { Logger } from '../common'

const objectostohate = ["los gatos", "las bicis","la basura", "madrugar", "ver tele", "los cuervos", "el aguacate", "tv azteca"];
const allhashtags =  ["#malavibra", "#nohate", "#everyday", "#oneday", "#popular", "#otrohashtag", "#region", "#mapa", "#rojo", "#blackhole"];

export class HateController {
    private static instance: HateController;
    private log: Logger;
    private db : any;

    private constructor()
    {
        
    }


    public fillHatePosts()
    {
        try
        {
            let quantity = 100;
            while (quantity>0)
            {
                const willpaid = Math.random()<=0.5 ? true : false;
                const amount = willpaid ? (Math.random()*300000.00) + 2000.0 : 0.0;
                const aproxHashtags = Math.trunc(Math.random()*4 + 1) / allhashtags.length;
                const postDate = new Date();
                postDate.setDate(postDate.getDate() - Math.trunc(Math.random()*700));
            }
        }
        catch(e)
        {
            this.log.error(e);
        }
    }

    public static getInstance() : HateController
    {
        if (!this.instance)
        {
            this.instance = new HateController();
        }
        return this.instance;
    }
}